--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 巨食尸鬼 魔杰拉  (ID: 45154513)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Zombie
-- Level 8
-- ATK 2800 | DEF 2300
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己场上的不死族怪兽被战斗·效果破坏的场合，可以作为代替把手卡·墓地的这张卡除外。
-- ②：这张卡从手卡·墓地除外的场合才能发动。这张卡守备表示特殊召唤。那之后，可以让这张卡的等级下降1星。
--[[ __CARD_HEADER_END__ ]]

--アルグールマゼラ
local s,id,o=GetID()
function c45154513.initial_effect(c)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,45154513)
	e1:SetTarget(c45154513.reptg)
	e1:SetValue(c45154513.repval)
	e1:SetOperation(c45154513.repop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(1,45154513+o)
	e2:SetCondition(c45154513.spcon)
	e2:SetTarget(c45154513.sptg)
	e2:SetOperation(c45154513.spop)
	c:RegisterEffect(e2)
end
function c45154513.repfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE) and c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
		and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c45154513.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c45154513.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c45154513.repval(e,c)
	return c45154513.repfilter(c,e:GetHandlerPlayer())
end
function c45154513.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT+REASON_REPLACE)
end
function c45154513.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND+LOCATION_GRAVE)
end
function c45154513.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c45154513.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(45154513,0)) then
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(-1)
		c:RegisterEffect(e1)
	end
end
