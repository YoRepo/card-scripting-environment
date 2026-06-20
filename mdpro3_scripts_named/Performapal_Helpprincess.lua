--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 娱乐伙伴 帮助公主  (ID: 88358139)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 4
-- ATK 1200 | DEF 1200
-- Setcode: 159
--
-- Effect Text:
-- ①：自己对「娱乐伙伴 帮助公主」以外的「娱乐伙伴」怪兽的召唤·特殊召唤成功时才能发动。这张卡从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--EMヘルプリンセス
function c88358139.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c88358139.spcon)
	e1:SetTarget(c88358139.sptg)
	e1:SetOperation(c88358139.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c88358139.cfilter(c,tp)
	return c:IsFaceup() and c:IsSummonPlayer(tp) and c:IsSetCard(0x9f) and not c:IsCode(88358139)
end
function c88358139.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c88358139.cfilter,1,nil,tp)
end
function c88358139.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c88358139.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
