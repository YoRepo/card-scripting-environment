--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 星见兽 加里斯  (ID: 30915572)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 3
-- ATK 800 | DEF 800
--
-- Effect Text:
-- 把手卡的这张卡给对方观看发动。自己卡组最上面的卡送去墓地，那张卡是怪兽的场合，给与对方基本分那只怪兽的等级×200的数值的伤害并把这张卡特殊召唤。那张卡是怪兽以外的场合，这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--星見獣ガリス
function c30915572.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30915572,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c30915572.spcost)
	e1:SetTarget(c30915572.sptarget)
	e1:SetOperation(c30915572.spoperation)
	c:RegisterEffect(e1)
end
function c30915572.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function c30915572.sptarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,1)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,1)
end
function c30915572.spoperation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.DiscardDeck(tp,1,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local tc=g:GetFirst()
	if tc then
		Duel.BreakEffect()
		if tc:IsType(TYPE_MONSTER) then
			Duel.Damage(1-tp,tc:GetLevel()*200,REASON_EFFECT)
			if not c:IsRelateToEffect(e) then return end
			Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		else
			if c:IsRelateToEffect(e) then Duel.Destroy(c,REASON_EFFECT) end
		end
	end
end
