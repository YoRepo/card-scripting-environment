--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: The Six Samurai - Yariza  (ID: 69025477)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level: 3
-- ATK 1000 | DEF 500
-- Setcode: 0x103d
-- Scope: OCG / TCG
--
-- Effect Text:
-- While you control a face-up "Six Samurai" monster with a different name, this card can attack your
-- opponent directly.
-- If this card would be destroyed, you can destroy another face-up "Six Samurai" monster you control
-- instead.
--[[ __CARD_HEADER_END__ ]]

--六武衆－ヤリザ
function c69025477.initial_effect(c)
	--diratk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c69025477.dircon)
	c:RegisterEffect(e1)
	--Destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c69025477.desreptg)
	e2:SetOperation(c69025477.desrepop)
	c:RegisterEffect(e2)
end
function c69025477.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x103d) and not c:IsCode(69025477)
end
function c69025477.dircon(e)
	return Duel.IsExistingMatchingCard(c69025477.cfilter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c69025477.repfilter(c,e)
	return c:IsFaceup() and c:IsSetCard(0x103d)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c69025477.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup()
		and Duel.IsExistingMatchingCard(c69025477.repfilter,tp,LOCATION_MZONE,0,1,c,e) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c69025477.repfilter,tp,LOCATION_MZONE,0,1,1,c,e)
		e:SetLabelObject(g:GetFirst())
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c69025477.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
