--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 隆隆隆左手与右手  (ID: 91718579)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 0 | DEF 2200
-- Setcode: 89
--
-- Effect Text:
-- ①：只要这张卡和这张卡以外的「隆隆隆」怪兽在怪兽区域存在，对方不能选择「隆隆隆」怪兽作为攻击对象，也不能作为效果的对象。
-- ②：只用包含这张卡的「隆隆隆」怪兽为素材的超量怪兽得到以下效果。
-- ●这次超量召唤成功时，以对方场上1只表侧攻击表示怪兽为对象才能发动。那只怪兽变成守备表示并把守备力变成0。
--[[ __CARD_HEADER_END__ ]]

--ゴゴゴアリステラ＆デクシア
function c91718579.initial_effect(c)
	--untargetable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCondition(c91718579.tgcon)
	e1:SetValue(c91718579.atlimit)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x59))
	e2:SetCondition(c91718579.tgcon)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--effect gain
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_BE_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_EVENT_PLAYER)
	e3:SetCondition(c91718579.effcon)
	e3:SetOperation(c91718579.effop)
	c:RegisterEffect(e3)
end
function c91718579.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x59)
end
function c91718579.tgcon(e)
	return Duel.IsExistingMatchingCard(c91718579.cfilter,0,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c91718579.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x59)
end
function c91718579.effcon(e,tp,eg,ep,ev,re,r,rp)
	local mg=e:GetHandler():GetReasonCard():GetMaterial()
	return r==REASON_XYZ and mg:IsExists(Card.IsSetCard,mg:GetCount(),nil,0x59)
end
function c91718579.effop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,91718579)
	local c=e:GetHandler()
	local rc=c:GetReasonCard()
	local e1=Effect.CreateEffect(rc)
	e1:SetDescription(aux.Stringid(91718579,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c91718579.poscon)
	e1:SetTarget(c91718579.postg)
	e1:SetOperation(c91718579.posop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	rc:RegisterEffect(e1,true)
	if not rc:IsType(TYPE_EFFECT) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_ADD_TYPE)
		e2:SetValue(TYPE_EFFECT)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		rc:RegisterEffect(e2,true)
	end
end
function c91718579.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c91718579.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c91718579.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c91718579.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c91718579.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c91718579.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c91718579.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsDefensePos() or not tc:IsRelateToEffect(e) then return end
	if Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)==0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(0)
	tc:RegisterEffect(e1)
end
