--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 蜂军巢  (ID: 25221249)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 303
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己的「蜂军」怪兽被选择作为攻击对象时才能发动。从手卡·卡组把1只「蜂军」怪兽特殊召唤，给这张卡放置1个指示物。那之后，战斗阶段结束。
-- ②：结束阶段，有指示物2个以上放置的这张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--B・F・N
function c25221249.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_SELF_TOGRAVE)
	c:EnableCounterPermit(0x51)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,25221249)
	e2:SetCondition(c25221249.condition)
	e2:SetTarget(c25221249.target)
	e2:SetOperation(c25221249.activate)
	c:RegisterEffect(e2)
	--to Grave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_SELF_TOGRAVE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c25221249.tgcon)
	c:RegisterEffect(e3)
end
function c25221249.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsFaceup() and tc:IsSetCard(0x12f)
end
function c25221249.filter(c,e,tp)
	return c:IsSetCard(0x12f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c25221249.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsCanAddCounter(tp,0x51,1,e:GetHandler()) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c25221249.filter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c25221249.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c25221249.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)~=0 and e:GetHandler():AddCounter(0x51,1)~=0 then
		Duel.BreakEffect()
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	end
end
function c25221249.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetCurrentPhase()==PHASE_END and c:GetCounter(0x51)>=2
end
