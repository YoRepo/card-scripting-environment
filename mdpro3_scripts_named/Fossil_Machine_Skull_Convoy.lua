--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 古生代化石机动车 骷髅大卡车  (ID: 57157964)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level 8
-- ATK 2100 | DEF 1800
-- Setcode: 329
--
-- Effect Text:
-- 自己墓地的岩石族怪兽＋7星以上的怪兽
-- 这张卡用「化石融合」的效果才能从额外卡组特殊召唤。
-- ①：只要融合召唤的这张卡在怪兽区域存在，对方场上的怪兽的攻击力下降那怪兽的原本守备力数值。
-- ②：这张卡在同1次的战斗阶段中最多3次可以向怪兽攻击。
-- ③：这张卡战斗破坏对方怪兽时才能发动。给与对方1000伤害。
--[[ __CARD_HEADER_END__ ]]

--古生代化石マシン スカルコンボイ
function c57157964.initial_effect(c)
	aux.AddCodeList(c,59419719)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c57157964.matfilter,aux.FilterBoolFunction(Card.IsLevelAbove,7),true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FossilFusionLimit)
	c:RegisterEffect(e1)
	--extra attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
	e2:SetValue(2)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(57157964,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCondition(aux.bdocon)
	e3:SetTarget(c57157964.damtg)
	e3:SetOperation(c57157964.damop)
	c:RegisterEffect(e3)
	--atkdown
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetCondition(c57157964.atkcon)
	e4:SetValue(c57157964.atkval)
	c:RegisterEffect(e4)
end
function c57157964.matfilter(c,fc)
	return c:IsRace(RACE_ROCK) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(fc:GetControler())
end
function c57157964.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c57157964.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c57157964.atkcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c57157964.atkval(e,c)
	local val=math.max(c:GetBaseDefense(),0)
	return val*-1
end
