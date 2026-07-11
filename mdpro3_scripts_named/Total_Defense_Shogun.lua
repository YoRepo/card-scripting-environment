--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Total Defense Shogun  (ID: 75372290)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 6
-- ATK 1550 | DEF 2500
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is Normal or Flip Summoned: Change it to Defense Position.
-- This card can attack while in face-up Defense Position.
-- If it does, apply its ATK for damage calculation.
--[[ __CARD_HEADER_END__ ]]

--絶対防御将軍
function c75372290.initial_effect(c)
	--to defense
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75372290,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c75372290.postg)
	e1:SetOperation(c75372290.posop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DEFENSE_ATTACK)
	c:RegisterEffect(e3)
end
function c75372290.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c75372290.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
