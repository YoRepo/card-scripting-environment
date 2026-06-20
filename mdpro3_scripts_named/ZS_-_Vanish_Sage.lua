--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 异热同心从者-幻影贤者  (ID: 51865604)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 1
-- ATK 500 | DEF 100
-- Setcode: 8318
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：自己场上有「希望皇 霍普」怪兽存在的场合才能发动。自己从卡组抽1张。
-- ②：自己场上的怪兽在战斗阶段中被除外的场合，以那之内的1只为对象，把这张卡从场上除外才能发动。作为对象的怪兽在自己场上特殊召唤，对方场上有攻击力3000以下的怪兽存在的场合，选那之内的1只除外。
--[[ __CARD_HEADER_END__ ]]

--ZS－幻影賢者
function c51865604.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51865604,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,51865604)
	e1:SetCondition(c51865604.condition)
	e1:SetTarget(c51865604.target)
	e1:SetOperation(c51865604.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51865604,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCountLimit(1,51865604)
	e2:SetCondition(c51865604.spcon)
	e2:SetCost(c51865604.spcost)
	e2:SetTarget(c51865604.sptg)
	e2:SetOperation(c51865604.spop)
	c:RegisterEffect(e2)
end
function c51865604.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x107f)
end
function c51865604.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c51865604.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c51865604.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c51865604.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c51865604.spfilter(c,e,tp)
	return c:IsFaceup() and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsCanBeEffectTarget(e)
end
function c51865604.spcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE) and eg:IsExists(c51865604.spfilter,1,nil,e,tp)
end
function c51865604.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c51865604.rmfilter(c)
	return c:IsAttackBelow(3000) and c:IsAbleToRemove()
end
function c51865604.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c51865604.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c51865604.rmfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=eg:FilterSelect(tp,c51865604.spfilter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c51865604.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g=Duel.SelectMatchingCard(tp,c51865604.rmfilter,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
