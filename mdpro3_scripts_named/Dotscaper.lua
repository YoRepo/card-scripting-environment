--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 点阵图跳离士  (ID: 18789533)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Cyberse
-- Level 1
-- ATK 0 | DEF 2100
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个，决斗中各能使用1次。
-- ①：这张卡被送去墓地的场合才能发动。这张卡特殊召唤。
-- ②：这张卡被除外的场合才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ドットスケーパー
function c18789533.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(18789533,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,18789533+EFFECT_COUNT_CODE_DUEL)
	e1:SetCost(c18789533.cost)
	e1:SetTarget(c18789533.target)
	e1:SetOperation(c18789533.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_REMOVE)
	e2:SetCountLimit(1,18789534+EFFECT_COUNT_CODE_DUEL)
	c:RegisterEffect(e2)
end
function c18789533.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,18789533)==0 end
	Duel.RegisterFlagEffect(tp,18789533,RESET_PHASE+PHASE_END,0,1)
end
function c18789533.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c18789533.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
