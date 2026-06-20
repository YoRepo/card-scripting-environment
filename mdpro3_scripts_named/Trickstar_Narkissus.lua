--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 淘气仙星·那耳姬丝  (ID: 91505214)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 4
-- ATK 1000 | DEF 1800
-- Setcode: 251
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：对方受到效果伤害的场合才能发动。这张卡从手卡特殊召唤。
-- ②：只要这张卡在怪兽区域存在，每次对方把手卡·墓地的怪兽的效果发动，给与对方200伤害。
--[[ __CARD_HEADER_END__ ]]

--トリックスター・ナルキッス
function c91505214.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(91505214,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,91505214)
	e1:SetCondition(c91505214.sumcon)
	e1:SetTarget(c91505214.sumtg)
	e1:SetOperation(c91505214.sumop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c91505214.regop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c91505214.damcon)
	e3:SetOperation(c91505214.damop)
	c:RegisterEffect(e3)
end
function c91505214.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and ep~=tp
end
function c91505214.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c91505214.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c91505214.regop(e,tp,eg,ep,ev,re,r,rp)
	if rp==1-tp and re:IsActiveType(TYPE_MONSTER) and (re:GetActivateLocation()==LOCATION_GRAVE or re:GetActivateLocation()==LOCATION_HAND) then
		e:GetHandler():RegisterFlagEffect(91505214,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_CHAIN,0,1)
	end
end
function c91505214.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep~=tp and c:GetFlagEffect(91505214)~=0 and (re:GetActivateLocation()==LOCATION_GRAVE or re:GetActivateLocation()==LOCATION_HAND)
end
function c91505214.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,91505214)
	Duel.Damage(1-tp,200,REASON_EFFECT)
end
