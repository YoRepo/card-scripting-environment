--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 异界的棘紫兽  (ID: 80208323)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level 5
-- ATK 1100 | DEF 2200
--
-- Effect Text:
-- 这张卡在墓地存在，自己场上的怪兽被战斗破坏送去墓地时，这张卡可以从墓地特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合从游戏中除外。「异界的棘紫兽」的效果1回合只能发动1次。
--[[ __CARD_HEADER_END__ ]]

--異界の棘紫獣
function c80208323.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80208323,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCountLimit(1,80208323)
	e1:SetCondition(c80208323.spcon)
	e1:SetTarget(c80208323.sptg)
	e1:SetOperation(c80208323.spop)
	c:RegisterEffect(e1)
end
function c80208323.spfilter(c,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE) and c:IsPreviousControler(tp) and c:IsType(TYPE_MONSTER)
end
function c80208323.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c80208323.spfilter,1,nil,tp)
end
function c80208323.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c80208323.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end
