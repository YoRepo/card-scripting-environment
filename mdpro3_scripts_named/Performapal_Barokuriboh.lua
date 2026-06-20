--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 娱乐伙伴 巴洛克栗子球  (ID: 19050066)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 8
-- Pendulum Scales: L1 / R1
-- ATK 300 | DEF 3000
-- Setcode: 10748063
--
-- Effect Text:
-- ←1 【灵摆】 1→
-- ①：1回合1次，自己·对方的战斗阶段开始时才能发动。从卡组把1只攻击力300/守备力200的怪兽加入手卡。那之后，这张卡破坏。
-- 【怪兽效果】
-- ①：自己怪兽被战斗破坏时才能发动。这张卡从手卡特殊召唤。
-- ②：只要这张卡在怪兽区域存在，对方不能选择其他怪兽作为攻击对象。
-- ③：这张卡被攻击的场合，伤害步骤结束时变成攻击表示。
--[[ __CARD_HEADER_END__ ]]

--EMバロックリボー
function c19050066.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE_START)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c19050066.tgtg)
	e1:SetOperation(c19050066.tgop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c19050066.descon)
	e2:SetTarget(c19050066.destg)
	e2:SetOperation(c19050066.desop)
	c:RegisterEffect(e2)
	--atk limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetValue(c19050066.atklimit)
	c:RegisterEffect(e3)
	--to attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_DAMAGE_STEP_END)
	e4:SetOperation(c19050066.posop)
	c:RegisterEffect(e4)
end
function c19050066.tgfilter(c)
	return c:IsAttack(300) and c:IsDefense(200) and c:IsAbleToHand()
end
function c19050066.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19050066.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c19050066.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c19050066.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT)>0 and tc:IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,tc)
		Duel.BreakEffect()
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c19050066.cfilter(c,tp)
	return c:IsPreviousControler(tp)
end
function c19050066.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c19050066.cfilter,1,nil,tp)
end
function c19050066.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c19050066.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c19050066.atklimit(e,c)
	return c~=e:GetHandler()
end
function c19050066.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c==Duel.GetAttackTarget() and c:IsDefensePos() and c:IsRelateToBattle() then
		Duel.ChangePosition(c,POS_FACEUP_ATTACK)
	end
end
