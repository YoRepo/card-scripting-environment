--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 调皮宝贝·火灯娃  (ID: 18236002)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 3
-- ATK 1500 | DEF 500
-- Setcode: 288
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡作为「调皮宝贝」怪兽的所用融合素材或者所用连接素材送去墓地的场合才能发动。给与对方500伤害。那之后，可以从手卡·卡组把「调皮宝贝·火灯娃」以外的1只「调皮宝贝」怪兽守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--プランキッズ・ランプ
function c18236002.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,18236002)
	e1:SetCondition(c18236002.damcon)
	e1:SetTarget(c18236002.damtg)
	e1:SetOperation(c18236002.damop)
	c:RegisterEffect(e1)
end
function c18236002.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	return c:IsLocation(LOCATION_GRAVE) and rc:IsSetCard(0x120) and r&(REASON_FUSION+REASON_LINK)~=0 and not c:IsReason(REASON_RETURN)
end
function c18236002.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c18236002.spfilter(c,e,tp)
	return c:IsSetCard(0x120) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) and not c:IsCode(18236002)
end
function c18236002.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c18236002.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,e,tp)
	if Duel.Damage(1-tp,500,REASON_EFFECT)~=0 and #g>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.SelectYesNo(tp,aux.Stringid(18236002,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
