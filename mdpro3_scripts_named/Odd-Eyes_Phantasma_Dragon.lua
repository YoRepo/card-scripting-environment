--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 异色眼幻灵龙  (ID: 21770839)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Dragon
-- Level 8
-- ATK 3000 | DEF 2500
-- Setcode: 153
--
-- Effect Text:
-- ←0 【灵摆】 0→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：丢弃1张手卡才能发动。从自己的额外卡组把1只表侧表示的龙族灵摆怪兽加入手卡。
-- 【怪兽效果】
-- 这个卡名的①②的怪兽效果1回合各能使用1次。
-- ①：自己的灵摆区域有2张卡存在，自己的额外卡组有表侧表示的「异色眼」灵摆怪兽存在的场合才能发动。这张卡从手卡特殊召唤。这个效果发动的回合，自己不能灵摆召唤。
-- ②：这张卡向对方怪兽攻击的伤害计算时才能发动。那只对方怪兽的攻击力只在那次伤害计算时下降自己的额外卡组的表侧表示的灵摆怪兽数量×1000。
--[[ __CARD_HEADER_END__ ]]

--オッドアイズ・ファンタズマ・ドラゴン
function c21770839.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21770839,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,21770839)
	e1:SetCost(c21770839.thcost)
	e1:SetTarget(c21770839.thtg)
	e1:SetOperation(c21770839.thop)
	c:RegisterEffect(e1)
	--special summon from hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21770839,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,21770840)
	e2:SetCondition(c21770839.spcon)
	e2:SetCost(c21770839.spcost)
	e2:SetTarget(c21770839.sptg)
	e2:SetOperation(c21770839.spop)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(21770839,2))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCountLimit(1,21770841)
	e3:SetCondition(c21770839.atkcon)
	e3:SetOperation(c21770839.atkop)
	c:RegisterEffect(e3)
	Duel.AddCustomActivityCounter(21770839,ACTIVITY_SPSUMMON,c21770839.counterfilter)
end
function c21770839.counterfilter(c)
	return not c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function c21770839.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c21770839.thfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c21770839.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c21770839.thfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_EXTRA)
end
function c21770839.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c21770839.thfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c21770839.exfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x99) and c:IsType(TYPE_PENDULUM)
end
function c21770839.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldCard(tp,LOCATION_PZONE,0) and Duel.GetFieldCard(tp,LOCATION_PZONE,1)
		and Duel.IsExistingMatchingCard(c21770839.exfilter,tp,LOCATION_EXTRA,0,1,nil)
end
function c21770839.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(21770839,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTarget(c21770839.splimit)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
end
function c21770839.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end
function c21770839.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c21770839.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c21770839.atkfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsFaceup()
end
function c21770839.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=c:GetBattleTarget()
	local gc=Duel.GetMatchingGroupCount(c21770839.atkfilter,tp,LOCATION_EXTRA,0,nil)
	return c==Duel.GetAttacker() and d and d:IsFaceup() and not d:IsControler(tp) and gc>0
end
function c21770839.atkop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttacker():GetBattleTarget()
	local gc=Duel.GetMatchingGroupCount(c21770839.atkfilter,tp,LOCATION_EXTRA,0,nil)
	if d:IsRelateToBattle() and d:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e1:SetValue(-gc*1000)
		d:RegisterEffect(e1)
	end
end
