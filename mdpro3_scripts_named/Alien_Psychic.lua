--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Alien Psychic  (ID: 58012107)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Reptile
-- Level: 1
-- ATK 200 | DEF 100
-- Setcode: 0xc
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is changed to Defense Position when it is Normal Summoned or Flip Summoned.
-- Monsters with A-Counters cannot declare an attack.
--[[ __CARD_HEADER_END__ ]]

--エーリアン・サイコ
function c58012107.initial_effect(c)
	--to defense
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58012107,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c58012107.potg)
	e1:SetOperation(c58012107.poop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--cannot attack announce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e3:SetTarget(c58012107.atktg)
	c:RegisterEffect(e3)
end
function c58012107.potg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c58012107.poop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
function c58012107.atktg(e,c)
	return c:GetCounter(0x100e)>0
end
