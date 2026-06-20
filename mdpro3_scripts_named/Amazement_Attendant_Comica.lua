--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 惊乐园的案内人 ＜C丑角＞  (ID: 67314110)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1400 | DEF 1800
-- Setcode: 347
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡召唤成功时才能发动。从卡组选1张「游乐设施」陷阱卡在自己的魔法与陷阱区域盖放。
-- ②：以给怪兽装备的1张自己的「游乐设施」陷阱卡为对象才能发动。那张卡给1只自己场上的「惊乐」怪兽或者对方场上的表侧表示怪兽装备。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--驚楽園の案内人 ＜Comica＞
function c67314110.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67314110,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c67314110.settg)
	e1:SetOperation(c67314110.setop)
	c:RegisterEffect(e1)
	--equip change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(67314110,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,67314110)
	e2:SetTarget(c67314110.eqtg)
	e2:SetOperation(c67314110.eqop)
	c:RegisterEffect(e2)
end
function c67314110.setfilter(c)
	return c:IsSetCard(0x15c) and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function c67314110.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c67314110.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c67314110.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local tc=Duel.SelectMatchingCard(tp,c67314110.setfilter,tp,LOCATION_DECK,0,1,1,nil):GetFirst()
	if tc then
		Duel.SSet(tp,tc)
	end
end
function c67314110.eqfilter1(c,tp)
	return c:IsSetCard(0x15c) and c:IsType(TYPE_TRAP) and c:IsFaceup() and c:GetEquipTarget()
		and Duel.IsExistingMatchingCard(c67314110.eqfilter2,0,LOCATION_MZONE,LOCATION_MZONE,1,c:GetEquipTarget(),tp)
end
function c67314110.eqfilter2(c,tp)
	return c:IsFaceup() and (c:IsSetCard(0x15b) or not c:IsControler(tp))
end
function c67314110.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c67314110.eqfilter1(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c67314110.eqfilter1,tp,LOCATION_SZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c67314110.eqfilter1,tp,LOCATION_SZONE,0,1,1,nil,tp)
end
function c67314110.eqop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c67314110.eqfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,tc:GetEquipTarget(),tp)
		local ec=g:GetFirst()
		if ec then
			Duel.HintSelection(g)
			Duel.Equip(tp,tc,ec)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(c67314110.eqlimit)
			e1:SetLabelObject(ec)
			tc:RegisterEffect(e1)
		end
	end
end
function c67314110.eqlimit(e,c)
	return c==e:GetLabelObject()
end
