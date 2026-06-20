--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 邪心英雄 地狱狙魔  (ID: 50282757)
-- Type: Monster / Effect / Fusion
-- Attribute: FIRE
-- Race: Fiend
-- Level 6
-- ATK 2000 | DEF 2500
-- Setcode: 24584
--
-- Effect Text:
-- 「元素英雄 黏土侠」＋「元素英雄 爆热女郎」
-- 这张卡用「暗黑融合」的效果才能特殊召唤。
-- ①：这张卡只要在怪兽区域存在，不会被魔法卡的效果破坏。
-- ②：自己准备阶段发动。给与对方1000伤害。这个效果在这张卡在怪兽区域表侧守备表示存在的场合进行发动和处理。
--[[ __CARD_HEADER_END__ ]]

--E-HERO ヘル・スナイパー
function c50282757.initial_effect(c)
	aux.AddCodeList(c,94820406)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,84327329,58932615,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.DarkFusionLimit)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(50282757,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCondition(c50282757.condition)
	e2:SetTarget(c50282757.target)
	e2:SetOperation(c50282757.operation)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(c50282757.indesval)
	c:RegisterEffect(e3)
end
c50282757.material_setcode=0x8
c50282757.dark_calling=true
function c50282757.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPosition(POS_FACEUP_DEFENSE) and Duel.GetTurnPlayer()==tp
end
function c50282757.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,1000)
end
function c50282757.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or e:GetHandler():IsFacedown() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c50282757.indesval(e,re)
	return re:IsActiveType(TYPE_SPELL)
end
