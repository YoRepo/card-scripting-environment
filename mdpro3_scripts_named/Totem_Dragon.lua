--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 民艺龙  (ID: 564541)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Dragon
-- Level 2
-- ATK 400 | DEF 200
--
-- Effect Text:
-- 龙族怪兽上级召唤的场合，这张卡可以作为2只的数量解放。自己的准备阶段时这张卡在墓地存在，自己场上没有怪兽存在的场合，可以把这张卡表侧攻击表示特殊召唤。这个效果在自己墓地有龙族以外的怪兽存在的场合不能发
-- 动。这个效果特殊召唤的这张卡从场上离开的场合从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--ミンゲイドラゴン
function c564541.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c564541.dccon)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(564541,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1)
	e2:SetCondition(c564541.spcon)
	e2:SetTarget(c564541.sptg)
	e2:SetOperation(c564541.spop)
	c:RegisterEffect(e2)
end
function c564541.dccon(e,c)
	return c:IsRace(RACE_DRAGON)
end
function c564541.cfilter(c)
	return c:IsType(TYPE_MONSTER) and not c:IsRace(RACE_DRAGON)
end
function c564541.spcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and not Duel.IsExistingMatchingCard(c564541.cfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c564541.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c564541.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and not Duel.IsExistingMatchingCard(c564541.cfilter,tp,LOCATION_GRAVE,0,1,nil) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end
