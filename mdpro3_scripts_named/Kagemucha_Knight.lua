--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 影无茶骑士  (ID: 19353570)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 3
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己对3星怪兽的召唤成功时，这张卡可以从手卡特殊召唤。这张卡不能作为同调素材。
--[[ __CARD_HEADER_END__ ]]

--影無茶ナイト
function c19353570.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19353570,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c19353570.spcon)
	e1:SetTarget(c19353570.sptg)
	e1:SetOperation(c19353570.spop)
	c:RegisterEffect(e1)
	--unsynchroable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c19353570.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==tp and eg:GetFirst():IsLevel(3)
end
function c19353570.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c19353570.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
