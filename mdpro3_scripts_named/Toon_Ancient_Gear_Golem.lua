--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Toon Ancient Gear Golem  (ID: 7171149)
-- Type: Monster / Effect / Toon
-- Attribute: EARTH
-- Race: Machine
-- Level: 8
-- ATK 3000 | DEF 3000
-- Setcode: 0x62, 0x7
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot attack the turn it is Summoned.
-- While you control "Toon World" and your opponent controls no Toon monsters, this card can attack
-- your opponent directly.
-- If this card attacks a Defense Position monster, inflict piercing battle damage to your opponent.
-- If this card attacks, your opponent cannot activate any Spell/Trap Cards until the end of the Damage
-- Step.
--[[ __CARD_HEADER_END__ ]]

--トゥーン・アンティーク・ギアゴーレム
function c7171149.initial_effect(c)
	aux.AddCodeList(c,15259703)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c7171149.atklimit)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetCondition(c7171149.dircon)
	c:RegisterEffect(e4)
	--actlimit
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(0,1)
	e5:SetValue(c7171149.aclimit)
	e5:SetCondition(c7171149.actcon)
	c:RegisterEffect(e5)
	--pierce
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e6)
end
function c7171149.atklimit(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c7171149.cfilter1(c)
	return c:IsFaceup() and c:IsCode(15259703)
end
function c7171149.cfilter2(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c7171149.dircon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c7171149.cfilter1,tp,LOCATION_ONFIELD,0,1,nil)
		and not Duel.IsExistingMatchingCard(c7171149.cfilter2,tp,0,LOCATION_MZONE,1,nil)
end
function c7171149.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c7171149.actcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
