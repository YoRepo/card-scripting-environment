--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 蛇头食尸鬼  (ID: 90764875)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Rock
-- Level 1
-- ATK 100 | DEF 100
--
-- Effect Text:
-- 自己场上有「蛇头食尸鬼」存在的场合，支付300基本分才能发动。这张卡从手卡特殊召唤。「蛇头食尸鬼」的效果1回合可以使用最多2次。
--[[ __CARD_HEADER_END__ ]]

--ゴルゴニック・グール
function c90764875.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(90764875,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(2,90764875)
	e1:SetCondition(c90764875.spcon)
	e1:SetCost(c90764875.spcost)
	e1:SetTarget(c90764875.sptg)
	e1:SetOperation(c90764875.spop)
	c:RegisterEffect(e1)
end
function c90764875.cfilter(c)
	return c:IsFaceup() and c:IsCode(90764875)
end
function c90764875.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c90764875.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c90764875.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,300) end
	Duel.PayLPCost(tp,300)
end
function c90764875.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c90764875.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
