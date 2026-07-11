--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Fairy Tail - Rella  (ID: 52022648)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 4
-- ATK 1850 | DEF 1000
-- Setcode: 0x1db
-- Scope: OCG / TCG
--
-- Effect Text:
-- Neither player can target monsters on the field with Spell Cards or effects, except this one.
-- Once per turn: You can discard 1 Spell; equip 1 Equip Spell from your hand, Deck, or GY to this
-- card, but return that Equip Spell to the hand during the End Phase.
--[[ __CARD_HEADER_END__ ]]

--妖精伝姫－シンデレラ
function c52022648.initial_effect(c)
	--cannot be target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c52022648.tglimit)
	e1:SetValue(c52022648.tgval)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(52022648,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c52022648.eqcost)
	e2:SetTarget(c52022648.eqtg)
	e2:SetOperation(c52022648.eqop)
	c:RegisterEffect(e2)
end
function c52022648.tglimit(e,c)
	return c~=e:GetHandler()
end
function c52022648.tgval(e,re,rp)
	return re:IsActiveType(TYPE_SPELL)
end
function c52022648.costfilter(c,ec,tp)
	return c:IsType(TYPE_SPELL) and c:IsDiscardable()
		and Duel.IsExistingMatchingCard(c52022648.eqfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,c,ec)
end
function c52022648.eqcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c52022648.costfilter,tp,LOCATION_HAND,0,1,nil,e:GetHandler(),tp) end
	Duel.DiscardHand(tp,c52022648.costfilter,1,1,REASON_COST+REASON_DISCARD,nil,e:GetHandler(),tp)
end
function c52022648.eqfilter(c,ec)
	return c:IsType(TYPE_EQUIP) and c:CheckEquipTarget(ec)
end
function c52022648.eqtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
end
function c52022648.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 or c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c52022648.eqfilter),tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,c)
	local tc=g:GetFirst()
	if tc then
		Duel.Equip(tp,tc,c)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_SZONE)
		e1:SetOperation(c52022648.thop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c52022648.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
end
