--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 花札卫-桐-  (ID: 80630522)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 12
-- ATK 100 | DEF 100
-- Setcode: 230
--
-- Effect Text:
-- ①：自己场上有11星以下的「花札卫」怪兽存在的场合才能发动。这张卡从手卡特殊召唤。这个效果的发动后，直到回合结束时自己不是「花札卫」怪兽不能召唤·特殊召唤。
-- ②：这张卡被选择作为攻击对象时才能发动。那次攻击无效，战斗阶段结束。那之后，自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--花札衛－桐－
function c80630522.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c80630522.spcon)
	e1:SetTarget(c80630522.sptg)
	e1:SetOperation(c80630522.spop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetTarget(c80630522.target)
	e2:SetOperation(c80630522.operation)
	c:RegisterEffect(e2)
end
function c80630522.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xe6) and c:IsLevelBelow(11)
end
function c80630522.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c80630522.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c80630522.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c80630522.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c80630522.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
end
function c80630522.splimit(e,c)
	return not c:IsSetCard(0xe6)
end
function c80630522.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c80630522.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
