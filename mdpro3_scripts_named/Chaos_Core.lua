--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Chaos Core  (ID: 54040484)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 3
-- ATK 0 | DEF 0
-- Setcode: 0xcf
-- Scope: OCG / TCG
--
-- Effect Text:
-- When either player activates a card or effect that targets this card, or when your opponent's
-- monster targets it for an attack (Quick Effect): You can send up to 1 each of "Uria, Lord of Searing
-- Flames", "Hamon, Lord of Striking Thunder", and "Raviel, Lord of Phantasms" from your hand and/or
-- Deck to the GY, and if you do, place 1 Phantasm Counter on this card for each card sent to the GY,
-- and if you place at least 1, you take no battle damage this turn.
-- You can only use this effect of "Chaos Core" once per turn.
-- If this card would be destroyed by battle or card effect, you can remove 1 Phantasm Counter from
-- this card instead.
--[[ __CARD_HEADER_END__ ]]

--カオス・コア
function c54040484.initial_effect(c)
	c:EnableCounterPermit(0x57)
	aux.AddCodeList(c,6007213,32491822,69890967)
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54040484,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_BECOME_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,54040484)
	e1:SetCondition(c54040484.countcon1)
	e1:SetTarget(c54040484.counttg)
	e1:SetOperation(c54040484.countop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCondition(c54040484.countcon2)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c54040484.reptg)
	e3:SetOperation(c54040484.repop)
	c:RegisterEffect(e3)
end
function c54040484.countcon1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsContains(e:GetHandler())
end
function c54040484.countcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and e:GetHandler()==Duel.GetAttackTarget()
end
function c54040484.tgfilter(c)
	return c:IsCode(6007213,32491822,69890967) and c:IsAbleToGrave()
end
function c54040484.counttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c54040484.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) and c:IsCanAddCounter(0x57,1) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c54040484.fselect(g,c)
	return aux.dncheck(g) and c:IsCanAddCounter(0x57,g:GetCount())
end
function c54040484.countop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c54040484.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:SelectSubGroup(tp,c54040484.fselect,false,1,g:GetCount(),c)
	if sg and sg:GetCount()>0 and Duel.SendtoGrave(sg,REASON_EFFECT)~=0 then
		if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
		local og=Duel.GetOperatedGroup()
		local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
		if ct>0 and c:AddCounter(0x57,ct) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetTargetRange(1,0)
			e1:SetValue(1)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c54040484.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
		and c:IsCanRemoveCounter(tp,0x57,1,REASON_EFFECT)
	end
	return Duel.SelectEffectYesNo(tp,c,96)
end
function c54040484.repop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RemoveCounter(tp,0x57,1,REASON_EFFECT)
end
