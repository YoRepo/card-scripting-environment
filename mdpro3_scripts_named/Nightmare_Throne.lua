--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 噩梦之玉座  (ID: 93729896)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：作为这张卡的发动时的效果处理，以下效果可以适用。
-- ●从卡组选1只攻击力和守备力是0的恶魔族怪兽加入手卡或破坏。
-- ②：1回合1次，自己场上的表侧表示的「于贝尔」怪兽因效果从场上离开的场合才能发动。原本等级比那之内的1只要高1星或低1星的1只「于贝尔」怪兽从自己的卡组·墓地·除外状态加入手卡。那之后，可以把那只怪兽
-- 无视召唤条件特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ナイトメア・スローン
local s,id,o=GetID()
function s.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
function s.thfilter(c)
	return c:IsRace(RACE_FIEND) and c:IsAttack(0) and c:IsDefense(0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.thfilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
		local sg=g:Select(tp,1,1,nil)
		local tc=sg:GetFirst()
		if tc:IsAbleToHand() and not Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,tc)
		else
			Duel.Destroy(tc,REASON_EFFECT)
		end
	end
end
function s.cfilter(c,tp)
	return c:IsSetCard(0x1a5) and c:IsReason(REASON_EFFECT) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousPosition(POS_FACEUP)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end
function s.filter(c,lv,tp)
	return s.cfilter(c,tp) and (c:IsLevel(lv-1) or c:IsLevel(lv+1))
end
function s.spfilter(c,e,tp,eg)
	local lv=c:GetLevel()
	return c:IsSetCard(0x1a5) and c:IsFaceupEx() and c:IsAbleToHand()
		and eg:IsExists(s.filter,1,nil,lv,tp)
end
--check in Operation
function s.spfilter2(c,e,tp,g)
	local lv=c:GetLevel()
	return c:IsSetCard(0x1a5) and c:IsFaceupEx() and c:IsAbleToHand()
		and g:IsExists(s.filter2,1,nil,lv,tp)
end
function s.filter2(c,lv,tp)
	return (c:IsLevel(lv-1) or c:IsLevel(lv+1))
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp,eg) end
	local g1=eg:Filter(s.cfilter,nil,tp)
	g1:KeepAlive()
	e:SetLabelObject(g1)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local g1=e:GetLabelObject()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(s.spfilter2),tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp,g1)
	local tc=sg:GetFirst()
	if tc and Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,tc)
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tc:IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
			Duel.BreakEffect()
			Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP)
		end
	end
end
