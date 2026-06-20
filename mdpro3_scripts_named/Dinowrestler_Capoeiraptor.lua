--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 恐龙摔跤手·卡波耶拉盗龙  (ID: 29996433)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dinosaur
-- Level 4
-- ATK 1800 | DEF 0
-- Setcode: 282
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：攻击表示的这张卡不会被战斗破坏，被对方怪兽攻击的伤害步骤结束时这张卡变成守备表示。
-- ②：这张卡在怪兽区域守备表示存在的场合，自己·对方的准备阶段才能发动。从卡组把1只「恐龙摔跤手·卡波耶拉盗龙」特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ダイナレスラー・カポエラプトル
function c29996433.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetCondition(c29996433.indcon)
	c:RegisterEffect(e1)
	--position
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c29996433.poscon)
	e2:SetOperation(c29996433.posop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(29996433,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,29996433)
	e3:SetCondition(c29996433.spcon)
	e3:SetTarget(c29996433.sptg)
	e3:SetOperation(c29996433.spop)
	c:RegisterEffect(e3)
end
function c29996433.indcon(e)
	return e:GetHandler():IsAttackPos()
end
function c29996433.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttackTarget() and e:GetHandler():IsRelateToBattle()
end
function c29996433.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
function c29996433.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDefensePos()
end
function c29996433.spfilter(c,e,tp)
	return c:IsCode(29996433) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c29996433.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c29996433.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c29996433.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c29996433.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
