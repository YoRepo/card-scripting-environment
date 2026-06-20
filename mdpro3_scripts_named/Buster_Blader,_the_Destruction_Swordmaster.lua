--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 使破坏剑的高手-破坏之剑士  (ID: 3428069)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Warrior
-- Level 7
-- ATK 2600 | DEF 2300
-- Setcode: 14090454
--
-- Effect Text:
-- ①：这张卡的卡名只要在场上·墓地存在当作「破坏之剑士」使用。
-- ②：对方场上的怪兽被战斗·效果破坏送去墓地的场合，以破坏的那1只怪兽为对象才能发动。那只怪兽当作装备卡使用给这张卡装备。
-- ③：1回合1次，把这张卡装备的1张怪兽卡送去墓地才能发动。和送去墓地的那张怪兽卡相同种族的对方场上的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--破壊剣の使い手－バスター・ブレイダー
function c3428069.initial_effect(c)
	--Code
	aux.EnableChangeCode(c,78193831,LOCATION_MZONE+LOCATION_GRAVE)
	--Equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(3428069,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e2:SetTarget(c3428069.eqtg)
	e2:SetOperation(c3428069.eqop)
	c:RegisterEffect(e2)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(3428069,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCost(c3428069.descost)
	e3:SetTarget(c3428069.destg)
	e3:SetOperation(c3428069.desop)
	c:RegisterEffect(e3)
end
function c3428069.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(1-tp)
		and c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_EFFECT+REASON_BATTLE) and c:IsCanBeEffectTarget(e) and not c:IsForbidden()
end
function c3428069.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c3428069.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and eg:IsExists(c3428069.filter,1,nil,e,tp) end
	local g=eg:Filter(c3428069.filter,nil,e,tp)
	local tc=nil
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		tc=g:Select(tp,1,1,nil):GetFirst()
	else
		tc=g:GetFirst()
	end
	Duel.SetTargetCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,tc,1,0,0)
end
function c3428069.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
		if not Duel.Equip(tp,tc,c,false) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c3428069.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c3428069.eqlimit(e,c)
	return e:GetOwner()==c
end
function c3428069.tgfilter(c,tp)
	return c:IsAbleToGraveAsCost()
		and Duel.IsExistingMatchingCard(c3428069.desfilter,tp,0,LOCATION_MZONE,1,nil,c:GetRace())
end
function c3428069.desfilter(c,rc)
	return c:IsFaceup() and c:IsRace(rc)
end
function c3428069.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEquipGroup():IsExists(c3428069.tgfilter,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=e:GetHandler():GetEquipGroup():FilterSelect(tp,c3428069.tgfilter,1,1,nil,tp)
	e:SetLabel(g:GetFirst():GetRace())
	Duel.SendtoGrave(g,REASON_COST)
end
function c3428069.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c3428069.desfilter,tp,0,LOCATION_MZONE,nil,e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c3428069.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c3428069.desfilter,tp,0,LOCATION_MZONE,nil,e:GetLabel())
	Duel.Destroy(g,REASON_EFFECT)
end
