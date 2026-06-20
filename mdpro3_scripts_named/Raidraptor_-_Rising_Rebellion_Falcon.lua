--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 急袭猛禽-起翼叛逆猎鹰  (ID: 71222868)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Winged Beast
-- Rank 13
-- ATK 4000 | DEF 3500
-- Setcode: 20644026
--
-- Effect Text:
-- 鸟兽族13星怪兽×5
-- ①：这张卡超量召唤的场合才能发动。对方场上的卡全部破坏。那之后，这张卡有「急袭猛禽」超量怪兽3种类以上在作为素材的场合，给与对方这个效果破坏的怪兽的原本攻击力合计数值的伤害。
-- ②：场上的这张卡不受其他卡的效果影响。
-- ③：1回合1次，把这张卡3个超量素材取除，以自己墓地1只「急袭猛禽」超量怪兽为对象才能发动。直到结束阶段，这张卡得到和那只怪兽相同的效果。
--[[ __CARD_HEADER_END__ ]]

--RR－ライジング・リベリオン・ファルコン
local s,id,o=GetID()
function s.initial_effect(c)
	--Xyz Summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_WINDBEAST),13,5)
	c:EnableReviveLimit()
	--immune
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(s.efilter)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(s.descon)
	e2:SetTarget(s.destg)
	e2:SetOperation(s.desop)
	c:RegisterEffect(e2)
	--copy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(s.copycost)
	e3:SetTarget(s.copytg)
	e3:SetOperation(s.copyop)
	c:RegisterEffect(e3)
end
function s.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function s.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function s.damval1(c)
	if c:GetLocation()~=LOCATION_MZONE then return end
	return math.max(0,c:GetTextAttack())
end
function s.damval2(c)
	if c:GetPreviousLocation()~=LOCATION_MZONE then return end
	return math.max(0,c:GetTextAttack())
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	local atk=g:GetSum(s.damval1)
	if atk>0 then Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0) end
end
function s.xfilter(c)
	return c:IsType(TYPE_XYZ) and c:IsSetCard(0xba)
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	if Duel.Destroy(g,REASON_EFFECT)>0 and c:IsRelateToEffect(e)
		and c:GetOverlayGroup():Filter(s.xfilter,nil):GetClassCount(Card.GetCode)>=3 then
		local dg=Duel.GetOperatedGroup()
		local atk=dg:GetSum(s.damval2)
		if atk>0 then
			Duel.BreakEffect()
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end
function s.filter(c)
	return c:IsSetCard(0xba) and c:IsType(TYPE_MONSTER) and c:IsType(TYPE_XYZ)
end
function s.copycost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(id)==0 and c:CheckRemoveOverlayCard(tp,3,REASON_COST) end
	c:RemoveOverlayCard(tp,3,3,REASON_COST)
	c:RegisterFlagEffect(id,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function s.copytg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,s.filter,tp,LOCATION_GRAVE,0,1,1,nil)
end
function s.copyop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
		local code=tc:GetOriginalCode()
		local cid=c:CopyEffect(code,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,1)
	end
end
