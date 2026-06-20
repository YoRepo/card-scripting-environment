--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 黯黑世界-暗影敌托邦-  (ID: 59160188)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：场上的表侧表示怪兽变成暗属性。
-- ②：1回合1次，自己为让卡的效果发动而把自己场上的怪兽解放的场合，可以作为自己场上1只怪兽的代替而把对方场上1只暗属性怪兽解放。
-- ③：自己·对方的结束阶段发动。把最多有这个回合这张卡表侧表示存在的状态被解放的怪兽数量的「暗影衍生物」（恶魔族·暗·3星·攻/守1000）在回合玩家的场上尽可能守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--闇黒世界－シャドウ・ディストピア－
function c59160188.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--attribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsFaceup))
	e2:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e2)
	--release replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_EXTRA_RELEASE_NONSUM)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK))
	e3:SetCountLimit(1)
	e3:SetValue(c59160188.relval)
	c:RegisterEffect(e3)
	--token
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_RELEASE)
	e4:SetRange(LOCATION_FZONE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetOperation(c59160188.regop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_PHASE+PHASE_END)
	e5:SetRange(LOCATION_FZONE)
	e5:SetCountLimit(1)
	e5:SetTarget(c59160188.sptg)
	e5:SetOperation(c59160188.spop)
	c:RegisterEffect(e5)
end
function c59160188.relval(e,re,r,rp)
	return (c59160188.re_activated or re:IsActivated()) and bit.band(r,REASON_COST)~=0
end
function c59160188.regfilter(c)
	local typ=c:IsPreviousLocation(LOCATION_ONFIELD) and c:GetPreviousTypeOnField() or c:GetType()
	return typ&TYPE_MONSTER>0
end
function c59160188.regop(e,tp,eg,ep,ev,re,r,rp)
	local mct=eg:FilterCount(c59160188.regfilter,nil)
	if mct==0 then return end
	local c=e:GetHandler()
	local ct=c:GetFlagEffectLabel(59160188)
	if ct then
		c:SetFlagEffectLabel(59160188,ct+mct)
	else
		c:RegisterFlagEffect(59160188,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1,mct)
	end
end
function c59160188.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=e:GetHandler():GetFlagEffectLabel(59160188)
	if ct then
		Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct,0,0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
	end
end
function c59160188.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetHandler():GetFlagEffectLabel(59160188)
	if not ct then return end
	local p=Duel.GetTurnPlayer()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,59160189,0,TYPES_TOKEN_MONSTER,1000,1000,3,RACE_FIEND,ATTRIBUTE_DARK,POS_FACEUP_DEFENSE,p) then return end
	local ft=Duel.GetLocationCount(p,LOCATION_MZONE)
	ct=math.min(ct,ft)
	if ct>1 and Duel.IsPlayerAffectedByEffect(p,59822133) then ct=1 end
	for i=1,ct do
		local token=Duel.CreateToken(tp,59160189)
		Duel.SpecialSummonStep(token,0,tp,p,false,false,POS_FACEUP_DEFENSE)
	end
	Duel.SpecialSummonComplete()
end
