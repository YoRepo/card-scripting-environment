--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 红莲地带的飞鹰  (ID: 26381750)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Winged Beast
-- Level 1
-- ATK 100 | DEF 0
--
-- Effect Text:
-- 这张卡被同调怪兽的同调召唤使用送去墓地的场合自己墓地有名字带有「熔岩」的怪兽3种类以上存在的场合，这张卡可以在自己场上特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--紅蓮地帯を飛ぶ鷹
function c26381750.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26381750,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetCondition(c26381750.spcon)
	e1:SetTarget(c26381750.sptg)
	e1:SetOperation(c26381750.spop)
	c:RegisterEffect(e1)
end
function c26381750.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
		and Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_GRAVE,0,nil,0x39):GetClassCount(Card.GetCode)>=3
end
function c26381750.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c26381750.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_GRAVE,0,nil,0x39):GetClassCount(Card.GetCode)<3 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end
