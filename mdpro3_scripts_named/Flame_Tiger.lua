--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 焰虎  (ID: 66499018)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast
-- Level 4
-- ATK 1800 | DEF 0
--
-- Effect Text:
-- 这张卡在墓地存在，自己场上没有怪兽存在的场合，自己的抽卡阶段时作为进行通常抽卡的代替才能发动。这张卡从墓地特殊召唤。这个效果特殊召唤的这张卡从场上离开的场合从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--焔虎
function c66499018.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66499018,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c66499018.condition)
	e1:SetTarget(c66499018.target)
	e1:SetOperation(c66499018.operation)
	c:RegisterEffect(e1)
end
function c66499018.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c66499018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return aux.IsPlayerCanNormalDraw(tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	aux.GiveUpNormalDraw(e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c66499018.operation(e,tp,eg,ep,ev,re,r,rp)
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
