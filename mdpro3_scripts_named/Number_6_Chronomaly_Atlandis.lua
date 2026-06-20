--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: No.6 先史遗产 大西洲巨人  (ID: 9161357)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Machine
-- Rank 6
-- ATK 2600 | DEF 3000
-- Setcode: 4718704
--
-- Effect Text:
-- 6星怪兽×2
-- ①：这张卡超量召唤成功时，以自己墓地1只「No.」怪兽为对象才能发动。那只怪兽当作装备卡使用给这张卡装备。
-- ②：这张卡的攻击力上升这张卡的效果装备的怪兽的攻击力一半数值。
-- ③：1回合1次，把这张卡1个超量素材取除，把这张卡的效果装备的自己的魔法与陷阱区域1张卡送去墓地才能发动。对方基本分变成一半。这个效果发动的回合，自己不能进行战斗阶段。
--[[ __CARD_HEADER_END__ ]]

--No.6 先史遺産アトランタル
function c9161357.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9161357,0))
	e1:SetCategory(CATEGORY_LEAVE_GRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c9161357.eqcon)
	e1:SetTarget(c9161357.eqtg)
	e1:SetOperation(c9161357.eqop)
	c:RegisterEffect(e1)
	--lp
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9161357,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c9161357.lpcost)
	e2:SetOperation(c9161357.lpop)
	c:RegisterEffect(e2)
end
aux.xyz_number[9161357]=6
function c9161357.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function c9161357.filter(c)
	return c:IsSetCard(0x48) and c:IsType(TYPE_MONSTER) and not c:IsForbidden()
end
function c9161357.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c9161357.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c9161357.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c9161357.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c9161357.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if not Duel.Equip(tp,tc,c,false) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c9161357.eqlimit)
		tc:RegisterEffect(e1)
		local atk=math.ceil(tc:GetBaseAttack()/2)
		if atk>0 then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD)
			e2:SetValue(atk)
			tc:RegisterEffect(e2)
		end
		tc:RegisterFlagEffect(9161357,RESET_EVENT+RESETS_STANDARD,0,1)
	end
end
function c9161357.eqlimit(e,c)
	return e:GetOwner()==c
end
function c9161357.lpfilter(c,tp)
	return c:GetFlagEffect(9161357)~=0 and c:IsControler(tp) and c:IsLocation(LOCATION_SZONE) and c:IsAbleToGraveAsCost()
end
function c9161357.lpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local eqg=c:GetEquipGroup()
	if chk==0 then return Duel.GetCurrentPhase()==PHASE_MAIN1 and eqg:IsExists(c9161357.lpfilter,1,nil,tp)
		and c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
	local ec=eqg:FilterSelect(tp,c9161357.lpfilter,1,1,nil,tp)
	Duel.SendtoGrave(ec,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c9161357.lpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,math.ceil(Duel.GetLP(1-tp)/2))
end
