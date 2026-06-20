--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 眷现之咒眼  (ID: 7610394)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 297
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：在自己场上把1只「咒眼之眷属衍生物」（恶魔族·暗·1星·攻/守400）特殊召唤。自己的魔法与陷阱区域有「太阴之咒眼」存在的场合，这个效果特殊召唤的数量可以变成2只。这张卡的发动后，直到回合结束时自
-- 己不是恶魔族怪兽不能特殊召唤。
-- ②：把墓地的这张卡除外才能发动。这个回合，自己场上的「咒眼」魔法·陷阱卡不会成为对方的效果的对象。
--[[ __CARD_HEADER_END__ ]]

--眷現の呪眼
function c7610394.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7610394,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,7610394)
	e1:SetTarget(c7610394.target)
	e1:SetOperation(c7610394.activate)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(7610394,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,7610395)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c7610394.imop)
	c:RegisterEffect(e2)
end
function c7610394.filter(c)
	return c:IsFaceup() and c:IsCode(44133040)
end
function c7610394.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,7610395,0x129,TYPES_TOKEN_MONSTER,400,400,1,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
end
function c7610394.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local flag=false
	if ft>0 and Duel.IsPlayerCanSpecialSummonMonster(tp,7610395,0x129,TYPES_TOKEN_MONSTER,400,400,1,RACE_FIEND,ATTRIBUTE_DARK) then
		if ft>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
			and Duel.IsExistingMatchingCard(c7610394.filter,tp,LOCATION_SZONE,0,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(7610394,2)) then
			flag=true
		end
		local token=Duel.CreateToken(tp,7610395)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		if flag==true then
			local token=Duel.CreateToken(tp,7610395)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		end
		Duel.SpecialSummonComplete()
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c7610394.splimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c7610394.splimit(e,c)
	return not c:IsRace(RACE_FIEND)
end
function c7610394.imop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetTarget(c7610394.imlimit)
	e1:SetValue(aux.tgoval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c7610394.imlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x129) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
