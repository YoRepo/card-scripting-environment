--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 霞之谷的雷鸟  (ID: 69448290)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Thunder
-- Level 3
-- ATK 1100 | DEF 700
-- Setcode: 55
--
-- Effect Text:
-- 场上表侧表示存在的这张卡回到手卡时，这张卡在自己场上特殊召唤。这个效果特殊召唤成功的回合，这张卡不能进行攻击。
--[[ __CARD_HEADER_END__ ]]

--霞の谷の雷鳥
function c69448290.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69448290,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_HAND)
	e1:SetCondition(c69448290.spcon)
	e1:SetTarget(c69448290.sptg)
	e1:SetOperation(c69448290.spop)
	c:RegisterEffect(e1)
end
function c69448290.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
		and e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c69448290.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c69448290.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then
		Duel.SendtoGrave(c,REASON_EFFECT)
		return
	end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
