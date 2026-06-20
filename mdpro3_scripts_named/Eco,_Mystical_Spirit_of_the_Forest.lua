--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 森之圣灵 厄科  (ID: 4192696)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 4
-- ATK 1700 | DEF 1000
-- Setcode: 8551
--
-- Effect Text:
-- 对方的卡的效果让自己受到伤害时才能发动。这张卡从手卡特殊召唤，给与对方基本分和受到的伤害相同的伤害。并且，再让这个回合双方受到的效果伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--森の聖霊 エーコ
function c4192696.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(4192696,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c4192696.spcon)
	e1:SetTarget(c4192696.sptg)
	e1:SetOperation(c4192696.spop)
	c:RegisterEffect(e1)
end
function c4192696.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and 1-tp==rp and bit.band(r,REASON_EFFECT)~=0
end
function c4192696.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ev)
end
function c4192696.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.Damage(1-tp,ev,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CHANGE_DAMAGE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,1)
		e1:SetValue(c4192696.damval)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_NO_EFFECT_DAMAGE)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
	end
end
function c4192696.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0
	else return val end
end
