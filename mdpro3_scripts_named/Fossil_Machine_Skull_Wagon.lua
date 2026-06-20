--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 中生代化石机动车 骷髅旅行车  (ID: 83656563)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Rock
-- Level 6
-- ATK 1700 | DEF 1500
-- Setcode: 329
--
-- Effect Text:
-- 自己墓地的岩石族怪兽＋5·6星的怪兽
-- 这张卡用「化石融合」的效果才能从额外卡组特殊召唤。这个卡名的③的效果1回合只能使用1次。
-- ①：这张卡在同1次的战斗阶段中最多2次可以向怪兽攻击。
-- ②：这张卡战斗破坏对方怪兽时才能发动。给与对方800伤害。
-- ③：把墓地的这张卡除外，以场上1张魔法·陷阱卡为对象才能发动。那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--中生代化石マシン スカルワゴン
function c83656563.initial_effect(c)
	aux.AddCodeList(c,59419719)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c83656563.matfilter1,c83656563.matfilter2,true)
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
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(83656563,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCondition(aux.bdocon)
	e3:SetTarget(c83656563.damtg)
	e3:SetOperation(c83656563.damop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(83656563,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCountLimit(1,83656563)
	e4:SetCost(aux.bfgcost)
	e4:SetTarget(c83656563.destg)
	e4:SetOperation(c83656563.desop)
	c:RegisterEffect(e4)
end
function c83656563.matfilter1(c,fc)
	return c:IsRace(RACE_ROCK) and c:IsLocation(LOCATION_GRAVE) and c:IsControler(fc:GetControler())
end
function c83656563.matfilter2(c,fc)
	return c:IsLevel(5,6)
end
function c83656563.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c83656563.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c83656563.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c83656563.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c83656563.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c83656563.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c83656563.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c83656563.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
