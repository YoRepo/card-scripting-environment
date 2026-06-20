--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 天孔邪鬼  (ID: 43739056)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Fiend
-- Level 3
-- ATK 1000 | DEF 1000
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，自己不能把这张卡以外的和这张卡相同属性的特殊召唤的怪兽的效果发动。
-- ②：1回合1次，自己·对方的主要阶段才能发动。这张卡的控制权移给对方。那之后，可以把这张卡的属性直到下个回合的结束时变更为任意属性。这个效果不在这张卡的原本持有者的回合不能发动。
--[[ __CARD_HEADER_END__ ]]

--天孔邪鬼
function c43739056.initial_effect(c)
	--actlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetValue(c43739056.actlimit)
	c:RegisterEffect(e1)
	--control
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(43739056,1))
	e2:SetCategory(CATEGORY_CONTROL)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c43739056.ctcon)
	e2:SetTarget(c43739056.cttg)
	e2:SetOperation(c43739056.ctop)
	c:RegisterEffect(e2)
end
function c43739056.actlimit(e,re,tp)
	local rc=re:GetHandler()
	local c=e:GetHandler()
	return re:IsActiveType(TYPE_MONSTER) and rc:IsSummonType(SUMMON_TYPE_SPECIAL) and re:GetActivateLocation()==LOCATION_MZONE
		and rc:IsAttribute(c:GetAttribute()) and rc~=c and tp==c:GetControler()
end
function c43739056.ctcon(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandler():GetOwner()
	return p==Duel.GetTurnPlayer() and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c43739056.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsControlerCanBeChanged() end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,e:GetHandler(),1,0,0)
end
function c43739056.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.GetControl(c,1-tp)>0 and Duel.SelectYesNo(tp,aux.Stringid(43739056,0)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTRIBUTE)
		local aat=Duel.AnnounceAttribute(tp,1,ATTRIBUTE_ALL&~e:GetHandler():GetAttribute())
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(aat)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END,2)
		c:RegisterEffect(e1)
	end
end
