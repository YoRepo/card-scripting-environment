--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 转生炎兽 赤狐  (ID: 86962245)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Cyberse
-- Level 3
-- ATK 1200 | DEF 1000
-- Setcode: 281
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：自己墓地的「转生炎兽」怪兽是3只以上的场合，把这张卡从手卡送去墓地，以自己墓地1只「转生炎兽」连接怪兽和对方的魔法与陷阱区域1张卡为对象才能发动。作为对象的墓地的怪兽回到额外卡组，作为对象的场上的
-- 卡破坏。
-- ②：这张卡在墓地存在，对方的魔法与陷阱区域的卡被破坏送去墓地的场合才能发动。这张卡守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--転生炎獣フォクサー
function c86962245.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86962245,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TODECK)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,86962245)
	e1:SetCondition(c86962245.condition)
	e1:SetCost(c86962245.cost)
	e1:SetTarget(c86962245.target)
	e1:SetOperation(c86962245.operation)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(86962245,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,86962245)
	e2:SetCondition(c86962245.spcon)
	e2:SetTarget(c86962245.sptg)
	e2:SetOperation(c86962245.spop)
	c:RegisterEffect(e2)
end
function c86962245.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x119)
end
function c86962245.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c86962245.cfilter,tp,LOCATION_GRAVE,0,3,nil)
end
function c86962245.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c86962245.filter(c)
	return c:GetSequence()<5
end
function c86962245.tdfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x119) and c:IsType(TYPE_LINK) and c:IsAbleToExtra()
end
function c86962245.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c86962245.filter,tp,0,LOCATION_SZONE,1,nil)
		and Duel.IsExistingTarget(c86962245.tdfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local lg=Duel.SelectTarget(tp,c86962245.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c86962245.filter,tp,0,LOCATION_SZONE,1,1,nil)
	e:SetLabelObject(g:GetFirst())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,1-tp,LOCATION_SZONE)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,lg,1,tp,LOCATION_GRAVE)
end
function c86962245.operation(e,tp,eg,ep,ev,re,r,rp)
	local sc=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local lc=g:GetFirst()
	if lc==sc then lc=g:GetNext() end
	if lc and lc:IsRelateToEffect(e) and Duel.SendtoDeck(lc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)>0 and lc:IsLocation(LOCATION_EXTRA) and sc and sc:IsRelateToEffect(e) then
		Duel.Destroy(sc,REASON_EFFECT)
	end
end
function c86962245.spfilter(c,tp)
	return c:IsReason(REASON_DESTROY) and c:IsPreviousLocation(LOCATION_SZONE)
		and c:IsPreviousControler(1-tp) and c:GetPreviousSequence()<5
end
function c86962245.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c86962245.spfilter,1,nil,tp)
end
function c86962245.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,tp,LOCATION_GRAVE)
end
function c86962245.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
