--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 贾特里克普斯异虫  (ID: 84932271)
-- Type: Monster / Effect / Toon
-- Attribute: LIGHT
-- Race: Reptile
-- Level 3
-- ATK 1200 | DEF 0
-- Setcode: 62
--
-- Effect Text:
-- 反转：这个回合这张卡被破坏送去墓地时，这张卡在自己场上守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ワーム・ジェートリクプス
function c84932271.initial_effect(c)
	--flip effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_FLIP)
	e1:SetOperation(c84932271.flipop)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84932271,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c84932271.spcon)
	e2:SetTarget(c84932271.sptg)
	e2:SetOperation(c84932271.spop)
	c:RegisterEffect(e2)
end
function c84932271.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsLocation(LOCATION_MZONE+LOCATION_GRAVE) then
		c:RegisterFlagEffect(84932271,RESET_EVENT+0x17a0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c84932271.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c84932271.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(84932271)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c84932271.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
