--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 次元融合杀  (ID: 89190953)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 70
--
-- Effect Text:
-- 自己场上有「神炎皇 乌利亚」「降雷皇 哈蒙」「幻魔皇 拉比艾尔」的其中任意种存在的场合，对方不能对应这张卡的发动把效果发动。
-- ①：从自己的手卡·场上·墓地把「幻魔」融合怪兽决定的融合素材怪兽除外，把那1只融合怪兽从额外卡组无视召唤条件特殊召唤。这个效果特殊召唤的怪兽的战斗发生的对自己的战斗伤害变成0。
--[[ __CARD_HEADER_END__ ]]

--次元融合殺
function c89190953.initial_effect(c)
	aux.AddCodeList(c,6007213,32491822,69890967)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c89190953.target)
	e1:SetOperation(c89190953.activate)
	c:RegisterEffect(e1)
end
function c89190953.filter1(c,e)
	return c:IsAbleToRemove() and not c:IsImmuneToEffect(e)
end
function c89190953.filter2(c,e,tp,m,chkf)
	return c:IsSetCard(0x144) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and c:CheckFusionMaterial(m,nil,chkf,true)
end
function c89190953.chfilter(c)
	return c:IsFaceup() and c:IsCode(6007213,32491822,69890967)
end
function c89190953.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=tp|0x200
		local mg=Duel.GetMatchingGroup(c89190953.filter1,tp,LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE,0,nil,e)
		return Duel.IsExistingMatchingCard(c89190953.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,mg,chkf)
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsExistingMatchingCard(c89190953.chfilter,tp,LOCATION_ONFIELD,0,1,nil) then
		Duel.SetChainLimit(c89190953.chainlm)
	end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,tp,LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c89190953.activate(e,tp,eg,ep,ev,re,r,rp)
	local chkf=tp|0x200
	local mg=Duel.GetMatchingGroup(aux.NecroValleyFilter(c89190953.filter1),tp,LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE,0,nil,e)
	local sg=Duel.GetMatchingGroup(c89190953.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,mg,chkf)
	if sg:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tg=sg:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		local mat=Duel.SelectFusionMaterial(tp,tc,mg,nil,chkf,true)
		Duel.Remove(mat,POS_FACEUP,REASON_EFFECT)
		Duel.BreakEffect()
		if Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetCondition(c89190953.damcon)
			e1:SetValue(1)
			e1:SetOwnerPlayer(tp)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_NO_BATTLE_DAMAGE)
			e2:SetCondition(c89190953.damcon2)
			tc:RegisterEffect(e2)
		end
		Duel.SpecialSummonComplete()
	end
end
function c89190953.damcon(e)
	return e:GetHandlerPlayer()==e:GetOwnerPlayer()
end
function c89190953.damcon2(e)
	return 1-e:GetHandlerPlayer()==e:GetOwnerPlayer()
end
function c89190953.chainlm(e,ep,tp)
	return tp==ep
end
