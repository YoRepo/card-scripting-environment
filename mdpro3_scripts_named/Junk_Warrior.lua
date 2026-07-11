--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Junk Warrior  (ID: 60800381)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Warrior
-- Level: 5
-- ATK 2300 | DEF 1300
-- Setcode: 0x66, 0x43
-- Scope: OCG / TCG
--
-- Effect Text:
-- "Junk Synchron" + 1+ non-Tuner monsters
-- If this card is Synchro Summoned: It gains ATK equal to the total ATK of all Level 2 or lower
-- monsters you currently control.
--[[ __CARD_HEADER_END__ ]]

--ジャンク・ウォリアー
function c60800381.initial_effect(c)
	aux.AddMaterialCodeList(c,63977008)
	--synchro summon
	aux.AddSynchroProcedure(c,c60800381.tfilter,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60800381,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c60800381.con)
	e1:SetOperation(c60800381.op)
	c:RegisterEffect(e1)
end
c60800381.material_setcode=0x1017
function c60800381.tfilter(c)
	return c:IsCode(63977008) or c:IsHasEffect(20932152)
end
function c60800381.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c60800381.filter(c)
	return c:IsFaceup() and c:IsLevelBelow(2)
end
function c60800381.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c60800381.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local atk=0
		local tc=g:GetFirst()
		while tc do
			atk=atk+tc:GetAttack()
			tc=g:GetNext()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
