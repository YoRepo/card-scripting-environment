--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 宝玉的祝福  (ID: 85766789)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 52
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：选自己的魔法与陷阱区域最多2张「宝玉兽」怪兽卡特殊召唤，自己基本分回复那个原本攻击力合计的数值。
-- ②：这张卡在墓地存在的状态，自己的魔法与陷阱区域有「宝玉兽」卡被放置的场合，把这张卡除外才能发动（伤害步骤也能发动）。自己卡组最上面的卡翻开，那是「宝玉兽」怪兽的场合，那只怪兽加入手卡或特殊召唤。不是
-- 的场合，那张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--宝玉の祝福
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
	--flip
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_MOVE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,id)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(s.flipcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(s.fliptg)
	e2:SetOperation(s.flipop)
	c:RegisterEffect(e2)
end
function s.filter(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x1034) and c:GetOriginalType()&TYPE_MONSTER>0 and c:GetSequence()<5
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_SZONE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_SZONE)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_SZONE,0,1,math.min(ft,2),nil,e,tp)
	if #g==0 then return end
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	local atk=Duel.GetOperatedGroup():GetSum(Card.GetBaseAttack)
	Duel.Recover(tp,atk,REASON_EFFECT)
end
function s.cfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x1034) and c:IsControler(tp) and c:IsLocation(LOCATION_SZONE) and c:GetSequence()<5
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end
function s.fliptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
		and (Duel.GetDecktopGroup(tp,1):IsExists(Card.IsAbleToHand,1,nil)
			or Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummon(tp)
				and not Duel.IsPlayerAffectedByEffect(tp,63060238)) end
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsPlayerCanDiscardDeck(tp,1) then return end
	Duel.ConfirmDecktop(tp,1)
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local b1=tc:IsAbleToHand()
	local b2=ft>0 and tc:IsCanBeSpecialSummoned(e,0,tp,false,false)
	if tc:IsSetCard(0x1034) and tc:IsType(TYPE_MONSTER) and (b1 or b2) then
		if b1 and (not b2 or Duel.SelectOption(tp,1190,1152)==0) then
			Duel.DisableShuffleCheck()
			Duel.SendtoHand(tc,nil,REASON_EFFECT)
		else
			Duel.DisableShuffleCheck()
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_REVEAL)
	end
end
