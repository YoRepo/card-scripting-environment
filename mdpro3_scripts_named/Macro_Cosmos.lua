--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 大宇宙  (ID: 30241314)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：作为这张卡的发动时的效果处理，可以从手卡·卡组把1只「原始太阳 赫利俄斯」特殊召唤。
-- ②：只要这张卡在魔法与陷阱区域存在，被送去墓地的卡不去墓地而除外。
--[[ __CARD_HEADER_END__ ]]

--マクロコスモス
function c30241314.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c30241314.target)
	e1:SetOperation(c30241314.activate)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetTargetRange(LOCATION_DECK,LOCATION_DECK)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
end
function c30241314.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c30241314.filter(c,e,sp)
	return c:IsCode(54493213) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c30241314.activate(e,tp,eg,ep,ev,re,r,rp)
	local cg=Duel.GetMatchingGroup(c30241314.filter,tp,LOCATION_DECK+LOCATION_HAND,0,nil,e,tp)
	if cg:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		if Duel.SelectYesNo(tp,aux.Stringid(30241314,0)) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=cg:Select(tp,1,1,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
