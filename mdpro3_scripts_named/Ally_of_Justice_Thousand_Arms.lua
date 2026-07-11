--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Ally of Justice Thousand Arms  (ID: 85876417)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 4
-- ATK 1700 | DEF 0
-- Setcode: 0x1
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can attack all face-up LIGHT monsters your opponent controls once each.
-- If this card battles a non-LIGHT monster, destroy this card before damage calculation.
--[[ __CARD_HEADER_END__ ]]

--A・O・J サウザンド・アームズ
function c85876417.initial_effect(c)
	--attack all
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_ATTACK_ALL)
	e1:SetValue(c85876417.atkfilter)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(85876417,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetTarget(c85876417.destg)
	e2:SetOperation(c85876417.desop)
	c:RegisterEffect(e2)
end
function c85876417.atkfilter(e,c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c85876417.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local c=e:GetHandler()
		local a=Duel.GetAttacker()
		if a==c then a=Duel.GetAttackTarget() end
		return a and a:IsNonAttribute(ATTRIBUTE_LIGHT)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c85876417.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToBattle() then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
