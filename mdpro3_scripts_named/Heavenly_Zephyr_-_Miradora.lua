--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 风之天翼 米拉多羽蛇  (ID: 17063599)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level 7
-- ATK 2000 | DEF 2600
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次，那些发动和效果不会被无效化。
-- ①：对方从额外卡组把攻击力2000以上的怪兽特殊召唤的场合才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡从手卡的特殊召唤成功的场合，以从额外卡组特殊召唤的对方场上1只表侧表示怪兽为对象才能发动。这只怪兽表侧表示存在期间，作为对象的怪兽不能把效果发动。
--[[ __CARD_HEADER_END__ ]]

--風の天翼ミラドーラ
function c17063599.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17063599,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,17063599)
	e1:SetCondition(c17063599.spcon)
	e1:SetTarget(c17063599.sptg)
	e1:SetOperation(c17063599.spop)
	c:RegisterEffect(e1)
	--actlimit
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17063599,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CANNOT_INACTIVATE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CAN_FORBIDDEN)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,17063600)
	e2:SetCondition(c17063599.actcon)
	e2:SetTarget(c17063599.acttg)
	e2:SetOperation(c17063599.actop)
	c:RegisterEffect(e2)
end
function c17063599.cfilter(c,tp)
	return c:IsSummonLocation(LOCATION_EXTRA) and c:IsSummonPlayer(1-tp) and c:IsAttackAbove(2000) and c:IsFaceup()
end
function c17063599.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c17063599.cfilter,1,nil,tp)
end
function c17063599.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c17063599.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c17063599.actcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND)
end
function c17063599.filter(c)
	return c:IsFaceup() and c:IsSummonLocation(LOCATION_EXTRA) and c:GetType()&TYPE_EFFECT~=0
end
function c17063599.acttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c17063599.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c17063599.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c17063599.filter,tp,0,LOCATION_MZONE,1,1,nil)
end
function c17063599.actop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetCondition(c17063599.ctcon)
		tc:RegisterEffect(e1,true)
	end
end
function c17063599.ctcon(e)
	local c=e:GetOwner()
	local h=e:GetHandler()
	return c:IsHasCardTarget(h)
end
