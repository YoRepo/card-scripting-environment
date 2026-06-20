--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 魔界台本「浪漫的告白者」  (ID: 41803903)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 8428
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：选自己场上1只「魔界剧团」灵摆怪兽回到持有者手卡，原本卡名和回到手卡的怪兽不同的1只表侧表示的「魔界剧团」灵摆怪兽从自己的额外卡组守备表示特殊召唤。
-- ②：自己的额外卡组有表侧表示的「魔界剧团」灵摆怪兽存在，盖放的这张卡被对方的效果破坏的场合才能发动。从卡组选「魔界台本」魔法卡任意数量在自己的魔法与陷阱区域盖放。
--[[ __CARD_HEADER_END__ ]]

--魔界台本「ロマンティック・テラー」
function c41803903.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,41803903+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c41803903.target)
	e1:SetOperation(c41803903.activate)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCategory(CATEGORY_SSET)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c41803903.setcon)
	e2:SetTarget(c41803903.settg)
	e2:SetOperation(c41803903.setop)
	c:RegisterEffect(e2)
end
function c41803903.thfilter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x10ec) and c:IsAbleToHand()
		and Duel.IsExistingMatchingCard(c41803903.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function c41803903.spfilter(c,e,tp,hc)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x10ec)
		and not c:IsOriginalCodeRule(hc:GetOriginalCodeRule())
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
		and Duel.GetLocationCountFromEx(tp,tp,hc,c)>0
end
function c41803903.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41803903.thfilter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c41803903.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local hc=Duel.SelectMatchingCard(tp,c41803903.thfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp):GetFirst()
	if hc and Duel.SendtoHand(hc,nil,REASON_EFFECT)~=0 and hc:IsLocation(LOCATION_HAND) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c41803903.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,hc)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
	end
end
function c41803903.filter2(c)
	return c:IsSetCard(0x10ec) and c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c41803903.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and rp==1-tp and c:IsPreviousControler(tp)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEDOWN)
		and Duel.IsExistingMatchingCard(c41803903.filter2,tp,LOCATION_EXTRA,0,1,nil)
end
function c41803903.setfilter(c)
	return c:IsSetCard(0x20ec) and c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c41803903.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c41803903.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c41803903.setop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c41803903.setfilter,tp,LOCATION_DECK,0,nil)
	local ct=math.min(Duel.GetLocationCount(tp,LOCATION_SZONE),g:GetCount())
	if ct<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local sg=g:Select(tp,1,ct,nil)
	Duel.SSet(tp,sg)
end
