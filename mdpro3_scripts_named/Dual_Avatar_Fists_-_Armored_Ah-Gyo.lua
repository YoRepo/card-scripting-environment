--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 双天拳 铠阿  (ID: 60237530)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Warrior
-- Level 6
-- ATK 2100 | DEF 1500
-- Setcode: 335
--
-- Effect Text:
-- 「双天」怪兽×2
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡特殊召唤成功的场合，以对方场上1只攻击表示怪兽为对象才能发动。那只怪兽破坏。这个效果的发动后，直到回合结束时这张卡不能直接攻击。
-- ②：只要效果怪兽为素材作融合召唤的「双天」融合怪兽在自己场上存在，自己场上的「双天」融合怪兽的攻击力·守备力上升300。
--[[ __CARD_HEADER_END__ ]]

--双天拳 鎧阿
function c60237530.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x14f),2,true)
	--effect monster material check
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_MATERIAL_CHECK)
	e0:SetValue(c60237530.matcheck)
	c:RegisterEffect(e0)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(60237530,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,60237530)
	e1:SetTarget(c60237530.target)
	e1:SetOperation(c60237530.operation)
	c:RegisterEffect(e1)
	--atk & def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c60237530.adcon)
	e2:SetTarget(c60237530.ffilter)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function c60237530.matcheck(e,c)
	local g=c:GetMaterial()
	if g:IsExists(Card.IsType,1,nil,TYPE_EFFECT) then
		c:RegisterFlagEffect(85360035,RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD,0,1)
	end
end
function c60237530.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAttackPos() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAttackPos,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsAttackPos,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c60237530.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc,c=Duel.GetFirstTarget(),e:GetHandler()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
function c60237530.ffilter(e,c)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x14f)
end
function c60237530.fmfilter(c)
	return c:IsType(TYPE_FUSION) and c:IsSetCard(0x14f) and c:IsFaceup() and c:GetFlagEffect(85360035)~=0
end
function c60237530.adcon(e)
	local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c60237530.fmfilter,tp,LOCATION_MZONE,0,1,nil)
end
