--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Naglfar, Generaider Boss of Fire  (ID: 2881864)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level: 9
-- ATK 3100 | DEF 200
-- Setcode: 0x134
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can only control 1 "Naglfar, Generaider Boss of Fire".
-- If a card(s) you control would be destroyed by battle or card effect, you can destroy 1 "Generaider"
-- monster or 1 Beast-Warrior monster you control instead.
-- You can only use this effect of "Naglfar, Generaider Boss of Fire" once per turn.
--[[ __CARD_HEADER_END__ ]]

--炎の王 ナグルファー
function c2881864.initial_effect(c)
	c:SetUniqueOnField(1,0,2881864)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,2881864)
	e1:SetTarget(c2881864.desreptg)
	e1:SetValue(c2881864.desrepval)
	e1:SetOperation(c2881864.desrepop)
	c:RegisterEffect(e1)
end
function c2881864.repfilter(c,tp)
	return c:IsControler(tp) and c:IsOnField()
		and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE)
end
function c2881864.desfilter(c,e,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and (c:IsSetCard(0x134) or c:IsRace(RACE_BEASTWARRIOR))
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c2881864.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c2881864.repfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c2881864.desfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	if Duel.SelectEffectYesNo(tp,e:GetHandler(),96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c2881864.desfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
		e:SetLabelObject(g:GetFirst())
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	end
	return false
end
function c2881864.desrepval(e,c)
	return c2881864.repfilter(c,e:GetHandlerPlayer())
end
function c2881864.desrepop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,2881864)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
