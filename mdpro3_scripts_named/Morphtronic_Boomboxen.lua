--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Morphtronic Boomboxen  (ID: 92720564)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 4
-- ATK 1200 | DEF 400
-- Setcode: 0x26
-- Scope: OCG / TCG
--
-- Effect Text:
-- ● While in Attack Position, this card can attack twice during each Battle Phase.
-- ● Once per turn, while in Defense Position, when a face-up "Morphtronic" monster you control is
-- targeted for an attack: You can negate the attack.
--[[ __CARD_HEADER_END__ ]]

--D・ラジカッセン
function c92720564.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetCondition(c92720564.cona)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--def
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92720564,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c92720564.cond)
	e2:SetOperation(c92720564.opd)
	c:RegisterEffect(e2)
end
function c92720564.cona(e)
	return e:GetHandler():IsAttackPos()
end
function c92720564.cond(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.GetAttackTarget()
	return not c:IsDisabled() and c:IsDefensePos() and d:IsFaceup() and d:IsSetCard(0x26)
end
function c92720564.opd(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
