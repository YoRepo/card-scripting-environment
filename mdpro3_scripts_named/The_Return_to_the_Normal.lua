--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: The Return to the Normal  (ID: 56001930)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When exactly 1 monster is Normal or Special Summoned face-up (except during the Damage Step):
-- Destroy all monsters on the field with less ATK than that monster.
-- You can only activate 1 "The Return to the Normal" per turn.
--[[ __CARD_HEADER_END__ ]]

--怪蹴一色
function c56001930.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,56001930+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c56001930.condition)
	e1:SetTarget(c56001930.target)
	e1:SetOperation(c56001930.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c56001930.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetCount()==1 and eg:GetFirst():IsFaceup()
end
function c56001930.filter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk-1)
end
function c56001930.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	local atk=tc:GetAttack()
	if chk==0 then return Duel.IsExistingMatchingCard(c56001930.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,atk) end
	tc:CreateEffectRelation(e)
	local g=Duel.GetMatchingGroup(c56001930.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,atk)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c56001930.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c56001930.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tc:GetAttack())
		if g:GetCount()>0 then
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
end
