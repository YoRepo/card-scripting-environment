--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 月光舞狮子姬  (ID: 24550676)
-- Type: Monster / Effect / Fusion
-- Attribute: DARK
-- Race: Beast-Warrior
-- Level 10
-- ATK 3500 | DEF 3000
-- Setcode: 223
--
-- Effect Text:
-- 「月光舞豹姬」＋「月光」怪兽×2
-- 这张卡用以上记的卡为融合素材的融合召唤才能特殊召唤。
-- ①：场上的这张卡不会被对方的效果破坏，对方不能把场上的这张卡作为效果的对象。
-- ②：这张卡在同1次的战斗阶段中可以作2次攻击。
-- ③：1回合1次，这张卡向怪兽攻击的伤害步骤结束时才能发动。对方场上的特殊召唤的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--月光舞獅子姫
function c24550676.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,97165977,aux.FilterBoolFunction(Card.IsFusionSetCard,0xdf),2,false,false)
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(aux.fuslimit)
	c:RegisterEffect(e0)
	--Immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(aux.tgoval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(aux.indoval)
	c:RegisterEffect(e2)
	--Double attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(24550676,0))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DAMAGE_STEP_END)
	e4:SetCountLimit(1)
	e4:SetCondition(c24550676.condition)
	e4:SetTarget(c24550676.target)
	e4:SetOperation(c24550676.operation)
	c:RegisterEffect(e4)
end
function c24550676.condition(e,tp,eg,ep,ev,re,r,rp)
	return aux.dsercon(e,tp,eg,ep,ev,re,r,rp) and Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()
end
function c24550676.filter(c)
	return c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c24550676.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c24550676.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c24550676.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c24550676.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c24550676.filter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
