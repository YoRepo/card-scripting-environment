--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 射敌  (ID: 5574510)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：丢弃1张手卡，以对方场上1只持有等级的怪兽为对象才能发动。掷1次骰子，出现的数目的以下效果适用。
-- ●比作为对象的怪兽的等级大的场合：作为对象的怪兽破坏。那之后，可以把原本等级和那只怪兽相同的1只怪兽从卡组加入手卡。这个回合，自己不能把「射敌」的①的效果发动。
-- ●作为对象的怪兽的等级以下的场合：作为对象的怪兽的等级下降1星。
--[[ __CARD_HEADER_END__ ]]

--射敵
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_TOHAND|CATEGORY_SEARCH|CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(s.descon)
	e2:SetCost(s.descost)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,id)==0
end
function s.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function s.desilter(c)
	return c:IsFaceup() and c:IsLevelAbove(1)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and s.desilter(chkc)
		and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(s.desilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,s.desilter,tp,0,LOCATION_MZONE,1,1,nil)
end
function s.thfilter(c,lv)
	return c:IsLevel(lv) and c:IsAbleToHand()
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local dc=Duel.TossDice(tp,1)
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsType(TYPE_MONSTER) then
		if dc>tc:GetLevel() then
			if Duel.Destroy(tc,REASON_EFFECT)~=0 then
				local lv=tc:GetOriginalLevel()
				if lv>0 and Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil,lv)
					and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
					Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
					local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil,lv)
					if g:GetCount()>0 then
						Duel.BreakEffect()
						Duel.SendtoHand(g,nil,REASON_EFFECT)
						Duel.ConfirmCards(1-tp,g)
					end
				end
			end
			Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(aux.Stringid(id,2))
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
			e1:SetTargetRange(1,0)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		elseif tc:IsLevelAbove(dc) then
			local e1=Effect.CreateEffect(c)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_LEVEL)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(-1)
			tc:RegisterEffect(e1)
		end
	end
end
