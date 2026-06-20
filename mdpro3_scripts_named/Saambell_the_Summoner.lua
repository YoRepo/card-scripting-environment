--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 召唤师 塞姆贝尔  (ID: 45282603)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level 2
-- ATK 600 | DEF 400
--
-- Effect Text:
-- 自己的主要阶段时，可以把和这张卡相同等级的1只怪兽从手卡特殊召唤。这个效果只在这张卡在场上表侧表示存在能使用1次。
--[[ __CARD_HEADER_END__ ]]

--召喚師セームベル
function c45282603.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(45282603,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1)
	e1:SetTarget(c45282603.sptg)
	e1:SetOperation(c45282603.spop)
	c:RegisterEffect(e1)
end
function c45282603.filter(c,lv,e,tp)
	return c:IsLevel(lv) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c45282603.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c45282603.filter,tp,LOCATION_HAND,0,1,nil,e:GetHandler():GetLevel(),e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c45282603.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c45282603.filter,tp,LOCATION_HAND,0,1,1,nil,e:GetHandler():GetLevel(),e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
