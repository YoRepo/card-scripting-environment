--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 轰炸龙  (ID: 20586572)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dragon
-- Level 3
-- ATK 1000 | DEF 0
--
-- Effect Text:
-- ①：这张卡的攻击发生的双方的战斗伤害变成0。
-- ②：这张卡被战斗破坏送去墓地的场合发动。把让这张卡破坏的怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--ボマー・ドラゴン
function c20586572.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(20586572,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c20586572.condition)
	e1:SetTarget(c20586572.target)
	e1:SetOperation(c20586572.operation)
	c:RegisterEffect(e1)
	--damage val
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_NO_BATTLE_DAMAGE)
	e2:SetCondition(c20586572.damcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e3:SetCondition(c20586572.damcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c20586572.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
		and e:GetHandler():GetReasonCard():IsRelateToBattle()
end
function c20586572.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local rc=e:GetHandler():GetReasonCard()
	rc:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,rc,1,0,0)
end
function c20586572.operation(e,tp,eg,ep,ev,re,r,rp)
	local rc=e:GetHandler():GetReasonCard()
	if rc:IsRelateToEffect(e) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end
function c20586572.damcon(e)
	return Duel.GetAttacker()==e:GetHandler()
end
