--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 时间潜行者考勤机蝶  (ID: 74578720)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level 4
-- ATK 1000 | DEF 1000
-- Setcode: 294
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：对方战斗阶段把这张卡解放才能发动。这个回合只有1次，对方怪兽的攻击发生的对自己的战斗伤害由对方代受。
-- ②：这张卡在墓地存在的状态，自己场上的表侧表示的超量怪兽因效果从场上离开的场合才能发动。这张卡特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合除外。
--[[ __CARD_HEADER_END__ ]]

--クロノダイバー・タイムレコーダー
function c74578720.initial_effect(c)
	--battle damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(74578720,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(0,TIMING_BATTLE_START+TIMING_ATTACK)
	e1:SetCountLimit(1,74578720)
	e1:SetCondition(c74578720.bdcon)
	e1:SetCost(c74578720.bdcost)
	e1:SetOperation(c74578720.bdop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74578720,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,74578721)
	e2:SetCondition(c74578720.spcon)
	e2:SetTarget(c74578720.sptg)
	e2:SetOperation(c74578720.spop)
	c:RegisterEffect(e2)
end
function c74578720.bdcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) and Duel.GetTurnPlayer()==1-tp
end
function c74578720.bdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c74578720.bdop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c74578720.cfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp) and c:IsReason(REASON_EFFECT)
		and bit.band(c:GetPreviousTypeOnField(),TYPE_XYZ)~=0 and c:IsPreviousLocation(LOCATION_MZONE)
end
function c74578720.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c74578720.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function c74578720.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c74578720.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		c:RegisterEffect(e1)
	end
end
