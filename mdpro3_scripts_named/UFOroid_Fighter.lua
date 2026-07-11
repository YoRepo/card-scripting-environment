--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: UFOroid Fighter  (ID: 32752319)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Machine
-- Level: 10
-- ATK ? | DEF ?
-- Setcode: 0x16
-- Scope: OCG / TCG
--
-- Effect Text:
-- "UFOroid" + 1 Warrior monster
-- A Fusion Summon of this card can only be done with the above Fusion Materials.
-- The original ATK/DEF of this card become the combined original ATK of the 2 materials used for its
-- Fusion Summon.
--[[ __CARD_HEADER_END__ ]]

--ユーフォロイド・ファイター
function c32752319.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,7602840,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),1,false,false)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c32752319.atkcon)
	e1:SetOperation(c32752319.atkop)
	c:RegisterEffect(e1)
end
function c32752319.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c32752319.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	local atk=0
	while tc do
		local catk=tc:GetBaseAttack()
		atk=atk+catk
		tc=g:GetNext()
	end
	if atk~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_BASE_DEFENSE)
		c:RegisterEffect(e2)
	end
end
